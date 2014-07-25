require 'factory_girl'
require File.expand_path("../../spec/factories.rb", __FILE__)

class Seed
  include FactoryGirl::Syntax::Methods
  FactoryGirl.lint

  def plant
    build_enterprise
    build_force
    build_books
    build_law
  end

  def build_enterprise
    # During Spocks travels he documents some interesting facts for the official
    # journal of the leading cosmographic society in our galaxy, a major news
    # reporting channel and another cool magazine.
    spock      = create(:user, email: 'spock@enterprise.org', password: 'Live long')
    facts      = create(:template, name: 'Intergallactic Facts')
                 create(:element, name: 'average temperature', template: facts)
                 create(:element, name: 'average disposition', template: facts)
                 create(:element, name: 'airborne vessels', template: facts)
                 create(:element, name: 'systems at war', template: facts)
                 create(:element, name: 'systems at peace', template: facts)
                 create(:element, name: 'truces', template: facts)
    enterprise = create(:curator, name: 'The Enterprise', shortname: 'enterprise', template: facts)
                 create(:client,  name: 'Interstellar Cosmography', shortname: 'intcosmo', curator: enterprise)
                 create(:client,  name: 'Laser News Network', shortname: 'lnn', curator: enterprise)
                 create(:client,  name: 'The New New Yorker', shortname: 'newnewyorker', curator: enterprise)
  end
    
  def build_force
    # Yoda shares his zen wisdown with all who are interested in mastering the
    # force.
    yoda       = create(:user, email: 'yoda@jedi.org', password: 'Entry, I seek')
    ratios     = create(:template, name: 'Balances')
                 create(:element, name: 'entrepreneurship', template: ratios)
                 create(:element, name: 'socialness', template: ratios)
                 create(:element, name: 'creativity', template: ratios)
    slowforce  = create(:curator, name: 'Slow Force', shortname: 'slowforce', template: ratios)
                 create(:client,  name: 'Jasmine & Bob Yoga', shortname: 'jasmineyoga', curator: slowforce)
                 create(:client,  name: 'Musicology Ltd', shortname: 'musicology', curator: slowforce)
                 create(:client,  name: 'New Mixter', shortname: 'newmixter', curator: slowforce)
  end
    
  def build_books
    # Bookkeeper sharing data with its clients
    bookkeeper = create(:user, email: 'simone@chi.service', password: 'She rocks')
    numbers    = create(:template, name: 'Results')
                 create(:element, name: 'revenue', template: numbers)
                 create(:element, name: 'expenses', template: numbers)
                 create(:element, name: 'profit', template: numbers)
                 create(:element, name: 'loss', template: numbers)
    chicola    = create(:curator, name: 'Chi, Daughters & Co', shortname: 'chicoLA', template: numbers)
                 create(:client, name: 'Sparrow Hair Studio', shortname: 'sparrowhair', curator: chicola)
                 create(:client, name: 'Premium Tobacco', shortname: 'premiumsmokes', curator: chicola)
                 create(:client, name: 'Bobby Burgers', shortname: 'bburgers', curator: chicola)
                 create(:client, name: 'BlastYard Labs', shortname: 'blastlab', curator: chicola)
  end

  def build_law
    # Lawyer sharing advice with its clients
    lawyer     = create(:user, email: 'd.a.nierstein@nierstein.law', password: 'password')
    lawstream  = create(:template, name: 'Updates')
                 create(:element, name: 'ammendments', template: lawstream)
    nierstein  = create(:curator, name: 'Nierstein Law', shortname: 'nierstein', template: lawstream)
                 create(:client, name: 'White Partner Laundromats', shortname: 'whitewash', curator: nierstein)
  end
end

Seed.new.plant
