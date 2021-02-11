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

Category.create([
  {
    description: 'Diversos',
    status: true
  },
  {
    description: 'Papel Higiênico',
    status: true
  },
  {
    description: 'Alcool 70%',
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

Supplier.create([
  {
    description: 'Interno',
    type_document: 'CNPJ',
    document: '',
    address: 'AV Marechal Floriano, 114 - Rio de Janeiro/RJ - CEP: 20080-002',
    phone: '(21) 2216-7800',
    comment: ''
  }
])
