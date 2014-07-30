class LineSerializer < ActiveModel::Serializer
	attributes :name

	has_many :tasks, embed: :ids, key: "tasks"
end