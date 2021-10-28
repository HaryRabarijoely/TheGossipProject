class ChangeCommentReference < ActiveRecord::Migration[5.2]
  def change
    remove_reference(:comments, :gossip, index: false)
    add_reference(:comments, :commentable, polymorphic: true)
  end
end
