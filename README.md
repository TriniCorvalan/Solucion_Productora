# Solución Proyecto

- [x] Crear la relación entre los modelos (Group y Concert).Si no existe un FK crearla **(0,5 Puntos)**

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
- [x] Modificar el CRUD de Concert para que en el formulario pueda hacer la asociación con el modelo Group **(0,5 Puntos)**
  
*Para esta instrucción en particular debemos ir directamente al controlador de Concert, para decirle a sus parametros que ahora debe aceptar uno nuevo, por lo que en **concerts_controller.rb***

```ruby
def concert_params
    params.require(:concert).permit(:place, :attendance, :duration, :date, :group_id)
end
```
*Una vez dado la instrucción al controlador que deje guardar el parametro que hemos agregado, necesitamos ir al método **new** y **edit**, para poder agregar los datos de grupos al formulario, en ambos métodos agregamos está linea*

```ruby
@groups = Group.all
```
*Ahora debemos ir a la vista parcial del form de Concerts en **_form.html.erb** y agregar la opción de añadir el campo Group*

```ruby
<div class="field">
    <%= form.label :group_id %>
    <%= form.select :group_id, options_from_collection_for_select(@groups, :id, :name) %>
</div>
```
