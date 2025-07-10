// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html";
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import topbar from "../vendor/topbar";

// Hook to display OKLCH color values as links to oklch.com
const OklchColorValue = {
  mounted() {
    this.updateColorValue();
  },

  updateColorValue() {
    const theme = this.el.dataset.theme;
    const cssVar = this.el.dataset.cssVar;
    
    // Find the parent container with the theme attribute
    const themeContainer = this.el.closest(`[data-theme="${theme}"]`);
    if (!themeContainer) return;
    
    // Get the computed style from the theme container
    const computedStyle = window.getComputedStyle(themeContainer);
    const backgroundColor = computedStyle.getPropertyValue(cssVar);
    
    if (backgroundColor && backgroundColor !== 'N/A') {
      // Update the text content with the OKLCH value
      this.el.textContent = backgroundColor;
      
      // Create the oklch.com URL with the color values
      const oklchUrl = this.createOklchUrl(backgroundColor);
      this.el.href = oklchUrl;
      
      // Set text color based on background brightness
      this.updateTextColor(backgroundColor);
    } else {
      this.el.textContent = 'N/A';
      this.el.href = '#';
    }
  },

  createOklchUrl(oklchString) {
    // Parse OKLCH string like "oklch(49.12% 0.3096 275.75)"
    const match = oklchString.match(/oklch\(([^)]+)\)/);
    if (!match) return 'https://oklch.com/';
    
    const values = match[1].split(' ').map(v => v.trim());
    if (values.length < 3) return 'https://oklch.com/';
    
    const l = parseFloat(values[0]); // Lightness (0-100)
    const c = parseFloat(values[1]); // Chroma
    const h = parseFloat(values[2]); // Hue (degrees)
    
    // Format for oklch.com URL: https://oklch.com/#l,c,h,100
    return `https://oklch.com/#${l},${c},${h},100`;
  },

  updateTextColor(backgroundColor) {
    // Convert OKLCH to RGB for brightness calculation
    const rgb = this.oklchToRgb(backgroundColor);
    if (!rgb) return;
    
    // Calculate relative luminance (brightness)
    const luminance = this.calculateLuminance(rgb.r, rgb.g, rgb.b);
    
    // Use white text for dark backgrounds, black text for light backgrounds
    const textColor = luminance > 0.5 ? 'black' : 'white';
    
    // Apply the text color
    this.el.style.color = textColor;
  },

  oklchToRgb(oklchString) {
    // Parse OKLCH string like "oklch(49.12% 0.3096 275.75)"
    const match = oklchString.match(/oklch\(([^)]+)\)/);
    if (!match) return null;
    
    const values = match[1].split(' ').map(v => v.trim());
    if (values.length < 3) return null;
    
    const l = parseFloat(values[0]) / 100; // Lightness (0-1)
    const c = parseFloat(values[1]); // Chroma
    const h = parseFloat(values[2]); // Hue (degrees)
    
    // Convert OKLCH to RGB
    const rgb = this.oklchToRgbSimple(l, c, h);
    return rgb;
  },

  oklchToRgbSimple(l, c, h) {
    // Simplified OKLCH to RGB conversion
    // Convert hue to radians
    const hRad = (h * Math.PI) / 180;
    
    // Calculate a and b components
    const a = c * Math.cos(hRad);
    const b = c * Math.sin(hRad);
    
    // Simplified conversion to RGB
    const r = Math.max(0, Math.min(255, Math.round((l + a * 0.577) * 255)));
    const g = Math.max(0, Math.min(255, Math.round((l - a * 0.289 - b * 0.5) * 255)));
    const b_val = Math.max(0, Math.min(255, Math.round((l - a * 0.289 + b * 0.5) * 255)));
    
    return { r, g, b: b_val };
  },

  calculateLuminance(r, g, b) {
    // Convert sRGB to linear RGB
    const rsRGB = r / 255;
    const gsRGB = g / 255;
    const bsRGB = b / 255;
    
    const rLinear = rsRGB <= 0.03928 ? rsRGB / 12.92 : Math.pow((rsRGB + 0.055) / 1.055, 2.4);
    const gLinear = gsRGB <= 0.03928 ? gsRGB / 12.92 : Math.pow((gsRGB + 0.055) / 1.055, 2.4);
    const bLinear = bsRGB <= 0.03928 ? bsRGB / 12.92 : Math.pow((bsRGB + 0.055) / 1.055, 2.4);
    
    // Calculate relative luminance
    return 0.2126 * rLinear + 0.7152 * gLinear + 0.0722 * bLinear;
  }
};

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: { _csrf_token: csrfToken },
  hooks: { OklchColorValue }
});

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (_info) => topbar.show(300));
window.addEventListener("phx:page-loading-stop", (_info) => topbar.hide());

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;
