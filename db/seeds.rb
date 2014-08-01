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
    kirk       = create(:user, email: 'kirk@enterprise.org', password: 'Still captain')
    facts      = create(:template, name: 'Intergallactic Observations')
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
                 create(:curatorship, curator: enterprise, user: kirk, is_admin: true)
                 create(:curatorship, curator: enterprise, user: spock, is_admin: false)
  end
    
  def build_force
    # Yoda shares his zen wisdown with all who are interested in mastering the
    # force.
    yoda       = create(:user, email: 'yoda@jedi.org', password: 'Entry, I seek')
    zelda      = create(:user, email: 'zelda@hyrulebalance.org', password: 'Balance today')
    jasmine    = create(:user, email: 'jasmine@jasnbob.usa', password: 'Bog makes awful veggie burgers')
    bob        = create(:user, email: 'bob@jasnbob.usa', password: 'I make delightful veggie burgers')
    kwame      = create(:user, email: 'kwame@jasnbob.usa', password: 'They always talk about stupid burgers')
    ratios     = create(:template, name: 'Balances')
                 create(:element, name: 'entrepreneurship', template: ratios)
                 create(:element, name: 'socialness', template: ratios)
                 create(:element, name: 'creativity', template: ratios)
    slowforce  = create(:curator, name: 'Slow Force', shortname: 'slowforce', template: ratios)
    jas_n_bob  = create(:client,  name: 'Jasmine & Bob Yoga', shortname: 'jasmineyoga', curator: slowforce)
                 create(:client,  name: 'Musicology Ltd', shortname: 'musicology', curator: slowforce)
    hyrule     = create(:client,  name: 'Hyrule Balance', shortname: 'hyrulebalance', curator: slowforce)
                 create(:membership, client: hyrule, user: zelda, is_admin: true)
                 create(:membership, client: jas_n_bob, user: jasmine, is_admin: true)
                 create(:membership, client: jas_n_bob, user: bob, is_admin: true)
                 create(:membership, client: jas_n_bob, user: kwame, is_admin: false)
  end
    
  def build_books
    # Bookkeeper sharing data with its clients
    bookkeeper = create(:user, email: 'simone@chi.service', password: 'She rocks')
    daughter   = create(:user, email: 'angela@chi.service', password: 'I rock too much')
    numbers    = create(:template, name: 'Results')
                 create(:element, name: 'revenue', template: numbers)
                 create(:element, name: 'expenses', template: numbers)
                 create(:element, name: 'profit', template: numbers)
                 create(:element, name: 'loss', template: numbers)
    chi_and_co = create(:curator, name: 'Chi, Daughters & Co', shortname: 'chiandco', template: numbers)
                 create(:client, name: 'Sparrow Hair Studio', shortname: 'sparrowhair', curator: chi_and_co)
                 create(:client, name: 'Premium Tobacco', shortname: 'premiumsmokes', curator: chi_and_co)
                 create(:client, name: 'Bobby Burgers', shortname: 'bburgers', curator: chi_and_co)
                 create(:client, name: 'BlastYard Labs', shortname: 'blastlab', curator: chi_and_co)
                 create(:curatorship, curator: chi_and_co, user: bookkeeper, is_admin: true)
                 create(:curatorship, curator: chi_and_co, user: daughter, is_admin: false)
  end

  def build_law
    # Lawyer sharing advice with its clients
    lawyer     = create(:user, email: 'd.a.nierstein@nierstein.law', password: 'password in latin is signum')
    lawstream  = create(:template, name: 'Updates')
                 create(:element, name: 'ammendments', template: lawstream)
    nierstein  = create(:curator, name: 'Nierstein Law', shortname: 'nierstein', template: lawstream)
                 create(:client, name: 'White Partner Laundromats', shortname: 'whitewash', curator: nierstein)
                 create(:curatorship, curator: nierstein, user: lawyer, is_admin: true)
  end
end

Seed.new.plant
