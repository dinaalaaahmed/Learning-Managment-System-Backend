# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
    User.create!(
        {
            user_name: Faker::Name.unique.name,
            email: Faker::Internet.unique.email,
            password_digest: BCrypt::Password.create(Faker::Internet.unique.password),
            first_name: Faker::Name.unique.name,
            last_name: Faker::Name.unique.name,
            user_type: 'guest',
            birth_date: Faker::Date.between(from: '2014-09-23', to: '2014-09-25')
        }
    )
    end
    5.times do
        Course.create!(
            {
                name: Faker::Book.title,
                syllabus: Faker::Lorem.sentence,
                user_id: 3
            }
        )
        end

    5.times do
            Material.create!(
                {
                    material_type: 'yputube',
                    content:'.youtube.com',
                    course_id: 1
                }
            )
            end
            
                5.times do
                    Quiz.create!(
                        {
                            course_id: 1
                        }
                    )
                    end
                    5.times do
                        Question.create!(
                            {
                                ques:'what?',
                                answer:'yes',
                                choices: 'yes,No,Okay',
                                quiz_id: 1
                            }
                        )
                        end
                1.times do
                    Takequiz.create!(
                        {
                            user_id: 1,
                            quiz_id: 1,
                            grade: 10
                        }
                    )
                    end
            