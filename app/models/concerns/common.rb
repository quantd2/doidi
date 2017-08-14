module Common
  extend ActiveSupport::Concern

  # included do
  #   has_many :comments, as: :commentable
  # end

  def normalized_name
    self.class.to_s.tableize.singularize
  end

  def normalized_id
    normalized_name + "_" + self.id.to_s
  end

  # module ClassMethods
  #   def normalized_id
  #     #returns the article/event which has the least number of comments
  #   end
  # end
end
