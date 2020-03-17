# frozen_literal_string: true

# Module that adds the present method to any includer.
# present will constantize the current controller + action and
# return the presenter for that context
module Presenters
  def present(*objects)
    klass = "#{self.params[:controller].camelize}::#{params[:action].camelize}Presenter".constantize
    presenter = klass.new(*objects)
    presenter.view_context = view_context
    return presenter
  end
end
