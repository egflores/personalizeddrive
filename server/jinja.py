from jinja2 import Environment, FileSystemLoader
env = Environment(loader=FileSystemLoader('/Users/gestalt/bmw/personalizeddrive/server/templates/'))

#This will create a template environment with the default settings and a loader that looks up the templates in the templates folder inside the yourapplication python package. Different loaders are available and you can also write your own if you want to load templates from a database or other resources.


#To load a template from this environment you just have to call the get_template() method which then returns the loaded Template:

template = env.get_template('dashboard.html')

#To render it with some variables, just call the render() method:

print template.render(car='happy', car_data='{}', tank_level='44', fuel_range='65')


