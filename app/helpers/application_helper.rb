module ApplicationHelper
  def task_checkbox(task)
    button_name = task.incomplete? ? 'check_box_outline_blank' : 'check_box'
    "
      <button class='task-checkbox-btn waves-effect waves-light' type='submit' data-complete-path='#{complete_task_path(task)}' data-uncomplete-path='#{uncomplete_task_path(task)}'>
          <i class='material-icons'>#{button_name}</i>
      </button>
    ".html_safe
  end
end
