class AddClassRankToStudent < ActiveRecord::Migration[6.1]
  def change
    add_column :students, :class_rank, :integer
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
