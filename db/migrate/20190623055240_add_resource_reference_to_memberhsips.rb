class AddResourceReferenceToMemberhsips < ActiveRecord::Migration[5.1]
  def up
    change_table :memberships do |t|
      t.references :resource, polymorphic: true, index:true
    end
  end

  def down
    change_table :memberships do |t|
      t.remove_references :resource, polymorphic: true
    end
  end
end
