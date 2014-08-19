class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :done
end
