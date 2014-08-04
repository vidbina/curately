module ApplicationHelper
  def show_link(object, url = object, label = 'Show')
    link_to(label, url) if can?(:read, object)
  end

  def edit_link(object, url = object, label = 'Edit')
    link_to(label, url) if can?(:update, object)
  end

  def remove_link(object, url = object, label = 'Remove')
    link_to(label, url, :method => :delete, :confirm => 'Are you sure?') if can?(:destroy, object)
  end

  def new_link(object, url = [:new, (object.kind_of?(Class) ? object : object.class).name.underscore.to_sym], label = 'Add')
    link_to(label, url) if can?(:create, object)
  end
end
