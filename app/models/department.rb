class Department < ApplicationRecord
  belongs_to :unit
  validates_presence_of :name
  store_accessor :json_attributes, :queue, :queue_index

  def queue_enqueue(number)
    queue << { number: number, enqueued_at: Time.now }
    save
  end

  def queue_dequeue
    queue.delete_at(0).tap { save }
  end

  def queue_peek
    queue.first
  end

  def queue_rear
    queue.last
  end
end
