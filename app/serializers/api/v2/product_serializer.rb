class Api::V2::ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :code, :product_type, :measure, :min, :med, :max, :location, :status, :group_id, :category_id, :quantity_in, :quantity_out, :quantity_inventory, :quantity_measure, :quantity_description, :created_at, :updated_at, :category, :group

  def quantity_in
    return Detail.joins(:product, :request).where(:product_id => object.id).where("request_type = 'in'").map {
      |d| d.quantity
    }.sum
  end

  def quantity_out
    return Detail.joins(:product, :request).where(:product_id => object.id).where("request_type = 'out'").map {
      |d| d.quantity
    }.sum
  end

  def quantity_inventory
    return quantity_in - quantity_out
  end

  def quantity_measure
    if quantity_inventory.to_i <= object.min.to_i
      return 'danger'
    elsif quantity_inventory.to_i > object.min.to_i && quantity_inventory.to_i <= object.med
      return 'warning'
    elsif quantity_inventory.to_i > object.med.to_i && quantity_inventory.to_i <= object.max
      return 'success'
    else
      return 'info'
    end
  end

  def quantity_description
    if quantity_measure == 'danger'
      return 'Abaixo da mínima'
    elsif quantity_measure == 'warning'
      return 'Acima da mínima'
    elsif quantity_measure == 'success'
      return 'Acima da média'
    else
      return 'Acima da máxima'
    end
  end

end
