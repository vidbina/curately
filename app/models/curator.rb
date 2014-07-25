class Curator < ActiveRecord::Base
  validates_length_of :name, minimum: 3, maximum: 40

  validates_length_of :shortname, minimum: 3, maximum: 15
  validates_format_of :shortname, with: /\A[a-zA-Z][a-zA-Z0-9]*\z/i

  has_many :curatorships, dependent: :destroy
  has_many :clients

  has_many :users, through: :curatorships

  has_objectid_columns :template_id

  def template
    if(@template)
      @template
    else
      @template = Template.find(template_id) unless template_id.nil?
    end
  end

  def template=(template)
    write_attribute(:template_id, template.id.to_binary)
    @template = template
  end

  def save
    super
  end
end
