class ResearchProgress < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  before_save :check_completed

  private

  def check_completed
    if progress >= item.req_research
      self.completed = true
      self.progress = item.req_research
    else
      self.completed = false
    end
    true
  end
end
