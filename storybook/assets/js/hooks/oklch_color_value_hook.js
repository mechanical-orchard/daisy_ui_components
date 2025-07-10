export const OklchColorValue = {
   mounted() { 
     let theme = this.el.dataset.theme;
     let cssVar = this.el.dataset.cssVar;
     let closestSelector = `[data-theme="${theme}"]`;
 
     const closestContainer = this.el.closest(closestSelector);
     if (closestContainer) {
       const computedStyle = window.getComputedStyle(closestContainer);
       const backgroundColor = computedStyle.getPropertyValue(cssVar);
       this.el.textContent = backgroundColor || 'N/A';
     }
  }
}