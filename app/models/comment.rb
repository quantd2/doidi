class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item

  alias_attribute :author, :user
  validates :body, presence: true

  default_scope { order(created_at: :desc) }

  has_ancestry
  paginates_per 10

  def notify_other_commenters
    users_to_notify.each do |user|
      Mailer.comment_response(self, user).deliver
    end
  end

  def users_to_notify
    ancestors.map(&:user).compact.select { |u| u.email.present? && u != user }
  end
end
