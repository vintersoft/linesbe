class LineSerializer < ActiveModel::Serializer
	attributes :id, :name, :links

	def links
		{ tasks: "/lines/#{ object.id }/tasks" }
	end

end
