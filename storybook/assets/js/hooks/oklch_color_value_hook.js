export const OklchColorValue = {
   mounted() { 
    this.updateColorValue();
  },

  updateColorValue() {
    let theme = this.el.dataset.theme;
    let cssVar = this.el.dataset.cssVar;
    let closestSelector = `[data-theme="${theme}"]`;

    const closestContainer = this.el.closest(closestSelector);
    if (closestContainer) {
      const computedStyle = window.getComputedStyle(closestContainer);
      const backgroundColor = computedStyle.getPropertyValue(cssVar);
      this.el.textContent = backgroundColor || 'N/A';
      // Calculate text color based on background brightness
      this.updateTextColor(backgroundColor);
    }
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
    // This is a simplified conversion - for production, consider using a color library
    const rgb = this.oklchToRgbSimple(l, c, h);
    return rgb;
  },

  oklchToRgbSimple(l, c, h) {
    // Simplified OKLCH to RGB conversion
    // For more accurate conversion, consider using a library like culori or chroma.js
    
    // Convert hue to radians
    const hRad = (h * Math.PI) / 180;
    
    // Calculate a and b components
    const a = c * Math.cos(hRad);
    const b = c * Math.sin(hRad);
    
    // Simplified conversion to RGB (this is approximate)
    // In a real implementation, you'd want to use proper color space conversion
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
}

