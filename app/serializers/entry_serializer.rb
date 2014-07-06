class EntrySerializer < ActiveModel::Serializer
  attributes :id, :name, :score, :rank

  
  def name
    object.entity.name
  end
  
  def rank
    object.rank
  end


end
