import { createElement } from "lwc";
import infoBox from "c/infoBox";

describe("c-info-box", () => {
  // reset DOM after each test
  afterEach(() => {
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
    jest.clearAllMocks();
  });

  test("render info box: success", () => {
    const element = createElement("c-info-box", {
      is: infoBox
    });
    element.variant = "success";
    element.message = "This is my success story";
    document.body.appendChild(element);

    const box = element.shadowRoot.querySelector(".info-box");
    expect(box.classList).toContain("box-theme_success");
    expect(box.textContent).toBe("This is my success story");
  });

  test("render info box: warning", () => {
    const element = createElement("c-info-box", {
      is: infoBox
    });
    element.variant = "warning";
    element.message = "This is my warning";
    document.body.appendChild(element);

    const box = element.shadowRoot.querySelector(".info-box");
    expect(box.classList).toContain("box-theme_warning");
    expect(box.textContent).toBe("This is my warning");
  });

  test("render info box: error", () => {
    const element = createElement("c-info-box", {
      is: infoBox
    });
    element.variant = "error";
    document.body.appendChild(element);

    const box = element.shadowRoot.querySelector(".info-box");
    expect(box.classList).toContain("box-theme_error");
  });

  test("render info box: default", () => {
    const element = createElement("c-info-box", {
      is: infoBox
    });
    document.body.appendChild(element);

    const box = element.shadowRoot.querySelector(".info-box");
    expect(box.classList).toContain("box-theme_default");
  });
});
