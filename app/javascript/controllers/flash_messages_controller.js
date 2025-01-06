import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    connect() {
        // Automatically hide flash messages after 2 seconds
        setTimeout(() => {
            this.fadeOut();
        }, 2000);
    }

    fadeOut() {
        this.element.style.transition = "opacity 0.5s ease, transform 0.5s ease";
        this.element.style.opacity = "0"; // Fade out
        this.element.style.transform = "translatey(-30px)"; // Move up
        setTimeout(() => this.element.remove(), 500); // Remove from DOM after fade out
    }
}