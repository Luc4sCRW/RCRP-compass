window.addEventListener('message', function (event) {
    const data = event.data;

    if (data.action === "updateHUD") {
        const dir = data.direction || "N";
        const street = data.street || "Unbekannte Straße";
        const time = data.time || "00:00";
        const zone = data.zone || "Los Santos";

        document.getElementById("dir").textContent = dir;
        document.getElementById("street").textContent = street;
        document.getElementById("timeZone").textContent = time;
        document.getElementById("zone").textContent = `${zone}, Los Santos`;
    }

    if (data.action === "toggleHud") {
        const hud = document.getElementById("hud");
        if (hud) {
            hud.style.display = data.show ? "block" : "none";
        }
    }
});

// DESIGN 2 made with ChatGPT
