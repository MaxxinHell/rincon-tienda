// Animación Fade In y Gestión del Formulario
document.addEventListener('DOMContentLoaded', () => {

    // PROBAR Y CONECTAR BASE DE DATOS SUPABASE
    if (typeof window.obtenerLibrosDesdeSupabase === 'function') {
        window.obtenerLibrosDesdeSupabase();
    }

    const revealEls = document.querySelectorAll('.reveal');

    if (!('IntersectionObserver' in window) || revealEls.length === 0) {
        revealEls.forEach(el => el.classList.add('visible'));
    } else {
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                    observer.unobserve(entry.target);
                }
            });
        }, { threshold: 0.15 });

        revealEls.forEach(el => observer.observe(el));
    }

    // FORMULARIO DE CONTACTO HACIA WHATSAPP
    const form = document.getElementById("form-contacto");

    if (form) {
        form.addEventListener("submit", function(e) {
            e.preventDefault();

            const nombre = document.getElementById("nombre").value.trim();
            const email = document.getElementById("email").value.trim();
            const mensaje = document.getElementById("mensaje").value.trim();

            if (nombre === "" || email === "" || mensaje === "") {
                const msg = document.getElementById("form-msg");
                msg.textContent = "Por favor, completa todos los campos.";
                msg.style.color = "red";
                return;
            }

            // Número de WhatsApp configurado (Código de país 52 para México + Número)
            const tuNumeroWhatsApp = "5215532517020";

            // Estructura del mensaje formateado para WhatsApp
            const textoMensaje = `📚 *EL RINCÓN DEL LIBRO*%0A%0A` +
                                 `📩 *NUEVO MENSAJE DE CONTACTO*%0A%0A` +
                                 `👤 *Nombre:* ${nombre}%0A` +
                                 `📧 *Correo:* ${email}%0A%0A` +
                                 `💬 *Mensaje:*%0A${mensaje}`;

            // URL oficial de redirección a la API de WhatsApp
            const urlWhatsApp = `https://wa.me/${tuNumeroWhatsApp}?text=${textoMensaje}`;

            // Abrir WhatsApp en una nueva pestaña
            window.open(urlWhatsApp, '_blank');

            // Notificación visual de éxito en la interfaz web
            const msg = document.getElementById("form-msg");
            msg.textContent = "✅ ¡Redirigiendo a WhatsApp para enviar el mensaje!";
            msg.style.color = "green";
            
            form.reset();
        });
    }

});