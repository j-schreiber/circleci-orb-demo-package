import { LightningElement, api } from "lwc";

export default class infoBox extends LightningElement {
  @api variant;
  @api message;
  @api margin;

  BASE_BOX_CLASSES = "slds-var-p-around_medium info-box";

  /**                 GETTERS AND FORMATTERS                       */

  get iconName() {
    if (this.variant === "error") {
      return "utility:error";
    } else if (this.variant === "success") {
      return "utility:success";
    }
    return "utility:info_alt";
  }

  get boxClasses() {
    return `${this.BASE_BOX_CLASSES} ${this.boxThemeClass} ${this.marginClass}`;
  }

  get boxThemeClass() {
    switch (this.variant) {
      case "error":
        return "box-theme_error";
      case "success":
        return "box-theme_success";
      case "warning":
        return "box-theme_warning";
      default:
        return "box-theme_default";
    }
  }

  get marginClass() {
    switch (this.margin) {
      case "small":
        return "slds-m-around_small";
      case "medium":
        return "slds-m-around_medium";
      case "large":
        return "slds-m-around_large";
      case "vertical-small":
        return "slds-m-vertical_small";
      case "vertical-medium":
        return "slds-m-vertical_medium";
      case "vertical-large":
        return "slds-m-vertical_large";
      default:
        return "slds-m-vertical_medium";
    }
  }
}
