window.addEventListener('message', function (event) {
    const data = event.data;

    if (data.action === "updateHUD") {
        // Himmelsrichtung und Straße aktualisieren / Update cardinal point and street
        document.getElementById("dir").textContent = data.direction || "N";
        document.getElementById("street").textContent = data.street || "Unbekannte Straße";

        // Uhrzeit + Zone anzeigen / display Time + Zone
        const zone = data.zone || "Los Santos";
        const time = data.time || "00:00";
        document.getElementById("timeZone").textContent = `${time} ${zone}, Los Santos`;
    }

    // HUD ein-/ausblenden / HUD show/hide
    if (data.action === "toggleHud") {
        const hud = document.getElementById("hud");
        if (hud) {
            hud.style.display = data.show ? "block" : "none";
        }
    }
});
