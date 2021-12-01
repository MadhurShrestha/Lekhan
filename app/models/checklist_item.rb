class ChecklistItem < ApplicationRecord
  belongs_to :checklist
   validates :status, inclusion: { in: ['not-started', 'in-progress', 'complete'] }
   validates_presence_of :status

  STATUS_OPTIONS = [
    ['Not started', 'not-started'],
    ['In progress', 'in-progress'],
    ['Complete', 'complete']
  ]

  def readable_status
    case status
    when 'not-started'
      'Not started'
    when 'in-progress'
      'In progress'
    when 'complete'
      'Complete'
    end
  end

  def color_class
    case status
    when 'not-started'
      'btn btn-outline-secondary'
    when 'in-progress'
      'btn btn-outline-info'
    when 'complete'
      'btn btn-outline-success'
    end
  end

  def complete?
    status == 'complete'
  end

  def in_progress?
    status == 'in-progress'
  end

  def not_started?
    status == 'not-started'
  end
end
