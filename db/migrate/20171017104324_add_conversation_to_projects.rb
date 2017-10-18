class AddConversationToProjects < ActiveRecord::Migration[5.1]
  def change
    add_reference :projects, :conversation, foreign_key: true
  end
end
