# Solución Proyecto

- [x] Crear la relación entre los modelos (Group y Concert).Si no existe un FK crearla**(0,5 Puntos)**

*Debemos correr una migración en la terminal para poder añadir el campo de la clave foranea al modelo Group)*

```ruby
rails generate migration AddGroupToConcerts concert:references
```
*Una vez generada y revisada la cargamos en nuestra base de datos*

```ruby
rails db:migrate
```
*Debemos agregar las relaciones a los modelos, en Group*

```ruby
has_many :concerts
```

*Y en el modelo Concert*

```ruby
belongs_to :groups
```
- [x] Modificar el CRUD de Concert para que en el formulario pueda hacer la asociación con el modelo Group**(0,5 Puntos)**
  
*Para esta instrucción en particular debemos ir directamente al controlador de Concert, para decirle a sus parametros que ahora debe aceptar uno nuevo, por lo que en **concerts_controller.rb***

```ruby
def concert_params
    params.require(:concert).permit(:place, :attendance, :duration, :date, :group_id)
end
```