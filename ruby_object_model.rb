##### => Ruby as a Multiparadigm Language

### => Everything is an object

# No primitives values

(1.5).class
(1.5).+(1)

10.class
10.*(2)

true.class
true.&(false)

false.class
false.&(true)

# Ruby runs between an object

self
self.class

# The top of inheritance is Object/BasicObject

Module.superclass
Module.ancestors

Class.superclass.superclass
Class.ancestors


### => Blocks and Main

# Blocks are not objects

-> {}
lambda {}
Proc.new {}

simon_que_si = -> (dato) { p self and p dato}

class LoQueSea
  def adios(&block)
    yield self
  end
end

LoQueSea.new.adios &simon_que_si
simon_que_si.yield(Array)
simon_que_si.yield(Array).new(2,"Hola").each{|s| p s.upcase }
simon_que_si.yield(TrueClass)
simon_que_si.call(LoQueSea)

# Main as the top of the context

def loquesea(r=true); p "Esto es #{r} -> #{self}"; end
def mi_mama_me_mima(n); Array.new(n,"mi mama me mima"); end

module HereWeGo
  class TheEnd
    loquesea
    mi_mama_me_mima(5)
  end
end

##### => Singleton Class in Ruby

### => Classes names are constants

class LoQueSea2; end
cincho = LoQueSea2.new
cincho.class
cincho.instance_of? Class
cincho.instance_of? LoQueSea2

LoQueSea2.class
LoQueSea2.instance_of? Class

LoQueSea3 = Class.new
cincho_2 = LoQueSea3.new
cincho_2.class
cincho_2.instance_of? Class
cincho_2.instance_of? LoQueSea2

cincho_3 = Class.new
cincho_3
cincho_3.new
(Class.new).new

Class.class

### => Accessing to singleton class

class << Array; end
def Array.yo_no_se_cua; end
Array.respond_to?(:yo_no_se_cua)

### => Rules valid for instances of classes also applies for classes

class AnotherClass
  class << self
    attr_accessor :hello, :inside
  end

  # @hello
  # @inside

  def self.loquesea_inside # singleton method also called protected
    hello = "Inside = singleton = instance of class Class"

    hello
  end

  def self.loquesea2_inside # singleton method also called protected
    inside

    outside
  end

  attr_accessor :hello, :outside

  def loquesea_outside
    hello = "outside = instance of class AnotherClass"

    hello
  end

  def loquesea2_outside
    outside 

    inside
  end
end

AnotherClass.loquesea_inside
AnotherClass.loquesea2_inside

AnotherClass.new.loquesea_outside
AnotherClass.new.loquesea2_outside

##### => Modules in Ruby

### => Classes vs modules

Class.superclass
Class.superclass.class
Class.instance_methods.-(Module.instance_methods)

### => Mixin

UnaClase = Class.new
UnModulo = Module.new do
  def metodo_de_un_modulo; "hola"; end
end

UnaClase.new.respond_to?(:metodo_de_un_modulo)
UnaClase.include(UnModulo)
UnaClase.new.respond_to?(:metodo_de_un_modulo)

UnaClase.respond_to?(:metodo_de_un_modulo)
UnaClase.extend(UnModulo)
UnaClase.respond_to?(:metodo_de_un_modulo)

respond_to?(:metodo_de_un_modulo)
include(UnModulo)
respond_to?(:metodo_de_un_modulo)

self.respond_to?(:metodo_de_un_modulo)
extend(UnModulo)
self.respond_to?(:metodo_de_un_modulo)

### => Rules valid for classes also applies for modules

module EstaCosa
  attr_accessor :aqui, :haya

  def initialize
    super

    @aqui = "Aquí"
    @haya = "Haya"
  end

  def ejecuta_aqui
    @aqui
  end

  def ejecuta_haya
    @haya
  end
end

MixinClase = Class.new
MixinClase.new.ejecuta_aqui
MixinClase.include EstaCosa
MixinClase.new.ejecuta_aqui

esta_cosa_pero_clase = MixinClase.new
esta_cosa_pero_clase.aqui=("Perfectirijillo")
esta_cosa_pero_clase.ejecuta_aqui

##### => Scopes in Ruby

### => Who is Self

class QuienEsSelf

  # very good
  def ejecutando_el_escope
    el_scope
  end

  def another_correct_implemantation
    self.class
  end

  # redundante
  def ejecutando_el_escope_2
    self.el_scope
  end

  private

  def el_scope
    Array.new(10) { |i| i+1 }
  end
end

la_insta = QuienEsSelf.new
la_insta.el_scope
QuienEsSelf.new.el_scope

### => Current scope → keys that changes scope → class, module and def

p self 

module QuePongo

  p self

  class YaNoSeQuePoner

    p self

    def el_metodo

      p self
    end

    p self.new.el_metodo
  end
end

QuePongo2 = Module.new do

  p self

  YaNoSeQuePoner2 = Class.new do

    p self

    define_method(:el_metodo_2) do

      p self

    end

    p self.new.el_metodo_2
  end
end

# singleton class

class << self
  p self
end

class YaNoSeQuePoner3
  p self

  class << self

    p self

    def el_metodo_3

      p self
    end
  end

  p el_metodo_3
end

####### PRACTICA #######

require 'active_record'
require 'mysql2'
require 'Jbuilder'

production_classrroms = {
  username: '#####',
  password: '#####',
  host: '#####',
  database: '#####',
  adapter: '#####'
}

ActiveRecord::Base.establish_connection production_classrroms
CustomActivity = Class.new(ActiveRecord::Base)
json = Jbuilder.new

custom_activities_in_json = json.custom_activities do
  json.array! CustomActivity.last(2) do |custom_activity|
    json.call(
      custom_activity,
      :id,
      :name,
      :description,
      :purpose,
      :locale,
      :center_id,
      :area_id,
      :min_age,
      :max_age,
      :theme_id,
      :media_content,
      :media_url,
      :age,
      :custom_activity_owner_id,
      :user_id
    )
  end
end
