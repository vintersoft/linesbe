class LineSerializer < ActiveModel::Serializer
	attributes :id, :name

	has_many :tasks, embed: :ids, key: "tasks"
end