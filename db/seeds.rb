# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Faker::Config.locale = 'fr'

User.destroy_all
City.destroy_all
Gossip.destroy_all
Tag.destroy_all
PrivateMessage.destroy_all
JoinTableMessageRecipient.destroy_all
Comment.destroy_all
Like.destroy_all

def pick_quote
  quote_reservoir = [
    Faker::TvShows::AquaTeenHungerForce,
    Faker::TvShows::BigBangTheory,
    Faker::TvShows::BojackHorseman,
    Faker::TvShows::Buffy,
    Faker::TvShows::DrWho,
    Faker::TvShows::DumbAndDumber,
    Faker::TvShows::FamilyGuy,
    Faker::TvShows::FinalSpace,
    Faker::TvShows::Friends,
    Faker::TvShows::GameOfThrones,
    Faker::TvShows::HeyArnold,
    Faker::TvShows::HowIMetYourMother,
    Faker::TvShows::MichaelScott,
    Faker::TvShows::NewGirl,
    Faker::TvShows::RickAndMorty,
    Faker::TvShows::RuPaul,
    Faker::TvShows::Seinfeld,
    Faker::TvShows::SiliconValley,
    Faker::TvShows::Simpsons,
    Faker::TvShows::SouthPark,
    Faker::TvShows::Stargate,
    Faker::TvShows::StrangerThings,
    Faker::TvShows::Suits,
    Faker::TvShows::TheExpanse,
    Faker::TvShows::TheFreshPrinceOfBelAir,
    Faker::TvShows::TheITCrowd,
    Faker::TvShows::TwinPeaks,
    Faker::TvShows::VentureBros,
    Faker::Movie,
    Faker::Movies::BackToTheFuture,
    Faker::Movies::Departed,
    Faker::Movies::Ghostbusters,
    Faker::Movies::HarryPotter,
    Faker::Movies::HitchhikersGuideToTheGalaxy,
    Faker::Movies::Hobbit,
    Faker::Movies::Lebowski,
    Faker::Movies::PrincessBride,
    Faker::Movies::StarWars,
    Faker::Movies::VForVendetta
  ]

  quote_reservoir[rand(0..(quote_reservoir.length - 1))].quote
end

def pick_recipient (private_message)
  user = User.all[rand(0..9)]
  user == private_message.sender ? pick_recipient(private_message) : user
end

10.times do
  City.create(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )
end

10.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: pick_quote,
    email: Faker::Internet.email,
    age: rand(18..80),
    city: City.all[rand(0..9)]
  )
end

10.times do
  Tag.create(
    title: Faker::Space.star
  )
end

20.times do
  gossip = Gossip.create(
    title: Faker::BossaNova.song,
    content: pick_quote,
    user: User.all[rand(0..9)]
  )

  JoinTableGossipTag.create(
    gossip: gossip,
    tag: Tag.all[rand(0..9)]
  )
end

10.times do
  JoinTableGossipTag.create(
    gossip: Gossip.all[rand(0..19)],
    tag: Tag.all[rand(0..9)]
  )
end

50.times do
  pm = PrivateMessage.create(
    content: pick_quote,
    sender: User.all[rand(0..9)]
  )

  JoinTableMessageRecipient.create(
    private_message: pm,
    recipient: pick_recipient(pm)
  )
end

20.times do
  private_message = PrivateMessage.all[rand(0..49)]
  recipient = pick_recipient(private_message)

  while private_message.recipients.include?(recipient)
    recipient = pick_recipient(private_message)
  end

  JoinTableMessageRecipient.create(
    private_message: private_message,
    recipient: recipient
  )
end

20.times do
  Comment.create(
    commentable: Gossip.all[rand(0..19)],
    user: User.all[rand(0..9)],
    content: pick_quote
  )
end

20.times do
  if rand(0..1) == 0
    likeable = Comment.all[rand(0..19)]
  else
    likeable = Gossip.all[rand(0..19)]
  end

  Like.create(
    user: User.all[rand(0..9)],
    likeable: likeable
  )
end

20.times do
  if rand(0..1) == 0
    commentable = Comment.all[rand(0..19)]
  else
    commentable = Gossip.all[rand(0..19)]
  end

  Comment.create(
    commentable: commentable,
    user: User.all[rand(0..9)],
    content: pick_quote
  )
end
