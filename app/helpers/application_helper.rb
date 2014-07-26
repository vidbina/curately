module ApplicationHelper
  def show_link(object, label = 'Show')
    link_to(label, object) if can?(:read, object)
  end

  def edit_link(object, label = 'Edit')
    link_to(label, object) if can?(:update, object)
  end

  def remove_link(object, label = 'Remove')
    link_to(label, object, :method => :delete, :confirm => 'Are you sure?') if can?(:destroy, object)
  end

  def new_link(object, label = 'Add')
    object_class = (object.kind_of?(Class) ? object : object.class)
    link_to(label, [:new, object_class.name.underscore.to_sym]) if can?(:create, object)
  end
end
