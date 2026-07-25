// ============================================================
// CONEXIÓN DIRECTA A BASE DE DATOS SUPABASE
// ============================================================

const SUPABASE_URL = 'https://vyvgjzflrgkhgarqagpe.supabase.co';
const SUPABASE_KEY = 'sb_publishable_7uNBu7oNTTjaFpGb91E80g_VD8tsBe1';

/**
 * Obtener todos los libros o filtrados por género desde la base de datos Supabase
 */
async function obtenerLibrosDesdeSupabase(genero = null) {
    try {
        let endpoint = `${SUPABASE_URL}/rest/v1/libros?select=*`;
        if (genero) {
            endpoint += `&genero=eq.${encodeURIComponent(genero)}`;
        }

        const response = await fetch(endpoint, {
            headers: {
                'apikey': SUPABASE_KEY,
                'Authorization': `Bearer ${SUPABASE_KEY}`
            }
        });

        if (!response.ok) {
            throw new Error(`HTTP Error: ${response.status}`);
        }

        const libros = await response.json();
        console.log("🟢 Conexión exitosa con Supabase. Libros obtenidos:", libros);
        return libros;
    } catch (error) {
        console.error("🔴 Error de conexión con Supabase:", error);
        return [];
    }
}

// Disponibilidad global para todo el proyecto
window.obtenerLibrosDesdeSupabase = obtenerLibrosDesdeSupabase;
