class Client < ActiveRecord::Base
  validates_length_of :name, minimum: 3, maximum: 40

  validates_length_of :shortname, minimum: 3, maximum: 15
  validates_format_of :shortname, with: /\A[a-zA-Z0-9]*\z/i

  belongs_to :curator

  has_many :memberships, dependent: :destroy
  has_many :curatorships, through: :curator

  def active?
    self[:is_active]
  end

  def deactivate
    self[:is_active] = false
    save
  end

  def activate
    self[:is_active] = true
    save
  end
end
