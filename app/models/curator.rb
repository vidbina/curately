class Curator < ActiveRecord::Base
  validates_length_of :name, minimum: 3, maximum: 40

  validates_length_of :shortname, minimum: 3, maximum: 15
  validates_format_of :shortname, with: /\A[a-zA-Z][a-zA-Z0-9]*\z/i

  has_many :curatorships, dependent: :destroy
  has_many :clients

  has_many :users, through: :curatorships

  has_objectid_columns :template_id

  def template
    @template ||= Template.find(self[:template_id].to_bson_id) if self[:template_id] && Template.where(id: self[:template_id].to_bson_id).exists?
  end

  def template=(template)
    return unless template.kind_of? Template
    write_attribute(:template_id, template.id.to_binary)
    @template = template
  end

  # TODO: extract this behaviour into reusable Module for Curator and Client
  def active
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

  def save
    super
  end
end
