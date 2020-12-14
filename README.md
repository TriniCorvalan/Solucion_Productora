# Solución Proyecto

- [x] Crear la relación entre los modelos (Group y Concert).Si no existe un FK crearla(0,5 Puntos)

:ring: *Debemos correr una migración en la terminal para poder añadir el campo de la clave foranea al modelo Group)

```ruby

rails generate migration AddConcertToGroups concert:references