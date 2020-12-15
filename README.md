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
- [x] En el Index de Group desplegar la lista de grupos que existen en la compañía y por cada uno mostrar la cantidad de conciertos que han tenido a lo largo de su historia profesional. **(1 Punto)**

*Para resolver este punto debe realizarse el siguiente codigo en **index.html.erb** de Group, agregando el encabezado **Concert** y una pequeña lista desordenada con los conciertos que ha tenido el grupo.*

```ruby
<th>Concerts</th>
.
.
.
.
<td>
    <ul>
        <% group.concerts.each do |concert| %>
            <li><%= concert.place %></li>
        <% end %>
    </ul>
</td>

```

*Sin embargo esto genera el famoso error N+1 Querys, por lo que para resolver este punto con honores, es necesario agregar*

```ruby
@groups = Group.eager_load(:concerts)
```

- [x] Desde la vista Index debo ser capaz de ver la información del grupo (Cantidad de integrantes, fecha en la que el grupo debutó y si es de hombres o mujeres)**(1 Punto)**

*Primero creamos el enum, para que el campo **type_group** pueda ingresar una selección*

```ruby
enum type_group: %w[Girlgroup Boygroup Band]
```

*En el método **new** y **edit** del controlador de Groups, agregamos esta linea de código para darle las opciones al select*

```ruby
@type_groups = Group.type_groups.keys.to_a
```

*Cambiamos el **number_field** que estaba con anterioridad en **type_group** a **select** para poder seleccionar el tipo de grupo manualmente*

```ruby
<div class="field">
    <%= form.label :type_group %>
    <%= form.select :type_group, options_for_select(@type_groups) %>
</div>

```
*Agregamos encabezados para la **fecha debut** y para **el tipo de grupo**, a su vez agregamos los campos que rellenaran estos encabezados*

```ruby
<th>Type Of Group</th>
<th>Debut Date</th>
.
.
.
<td><%= group.type_group %></td>
<td><%= group.debut_date %></td>

```
- [x] En el index de Group se debe mostrar la cantidad total de personas que han asistido por concierto de cada grupo **(1 Punto)**

*Para este requerimiento podemos agregarlo en la misma lista de conciertos*

```ruby
<td>
    <ul>
        <% group.concerts.each do |concert| %>
            <li><%= concert.place %>, <%= concert.attendance %> Asistentes</li>
        <% end %>
    </ul>
</td>
```

- [x] Si se termina el contrato de algún grupo, entonces se debe eliminar el registro de los conciertos del mismo.**(1 Punto)**

*Rails no nos deja borrar registros que son padres de otros, por defecto, por lo que debemos decirle que es algo intencional de nuestra parte. En **group.rb** agregaremos el siguiente complemento a la relación ya descrita con anterioridad*

```ruby
has_many :concerts, dependent: :destroy
```

- [x] En la vista Show de Group debe poder mostrar una tabla con los siguientes datos:
  
> - [x] Cuántos conciertos tuvo este mes **(2 Puntos)**

*para esto debemos hacer un método en el modelo que maneje la lógica de este requerimiento, lo llamaremos **concerts_this_month***

```ruby
def concerts_this_month
    f = []
    d =  self.concerts.map do |c|
            c.date.month
         end 
    d.each do |date|
        f << date if date == Time.now.month
    end  
    f.count
end
```

> - [x] Cuándo fue su último concierto con formato de fecha “Año - Mes en palabras- día en palabras”**(1 Punto)**

*Al igual que en el paso anterior y en los siguientes crearemos un método en **group.rb** lo llamaremos **last_concert***

```ruby
def last_concert
    concerts.map {|c|c.date}.max
end
```

> - [x] Cuanto es el número máximo de personas que ha ido a un concierto **(1 Punto)**

*Este método lo llamaremos **most_people***

```ruby
def most_people
    concerts.map {|c| c.attendance}.max
end
```

> - [x] Cuál ha sido el mayor tiempo que ha durado un concierto. **(1 Punto)**

*Este método lo llamaremos **longest_concert***

```ruby
def longest_concert
    concerts.map {|c| c.duration}.max
end
```

*Para poder mostrarlos en el index de **Group** necesitamos agregar los encabezados y agregar el contenido a la tabla de la siguiente forma*

```ruby
<th>Concerts This Month</th>
<th>Last Concert</th>
<th>Most Attendance</th>
<th>Longest Concert</th>
.
.
.
.
.
.
.
.
<td><%= group.concerts_this_month %></td>
<td><%= group.last_concert.strftime("%Y-%B-%A") %></td>
<td><%= group.most_people %></td>
<td><%= group.longest_concert %> hours</td>
```
