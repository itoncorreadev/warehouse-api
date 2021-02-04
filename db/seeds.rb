# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Group.create([
  {
    name: 'Diversos',
    status: true
  },
  {
    name: 'Alimentos e Bebidas',
    status: true
  },
  {
    name: 'Limpeza e Higiene',
    status: true
  }
])



Department.create([
  {
    description: 'Administrativo',
    status: true
  },
  {
    description: 'Captação de Recursos',
    status: true
  },
  {
    description: 'Recursos Humanos',
    status: true
  },
  {
    description: 'Tecnologia da Informação',
    status: true
  },
  {
    description: 'Markting e Comunicação',
    status: true
  },
  {
    description: 'Educacional',
    status: true
  },
  {
    description: 'Social',
    status: true
  }
])
