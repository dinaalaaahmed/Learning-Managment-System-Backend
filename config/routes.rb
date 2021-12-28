Rails.application.routes.draw do
  get 'pages/index'
  root 'pages#index'
      resource :users, :courses, :questions, :materials, :quizzes
      post "/users/sign-up", to: "authentication#create"
      post "/users/login", to: "authentication#login"
      post "/materials/create-file", to: "materials#create_file"

      get "/users/index", to: "users#index"
      get "/courses/index", to: "courses#index"
      get "/questions/index", to: "questions#index"
      get "/materials/index", to: "materials#index"
      get "/materials/show-file", to: "materials#show_file"                                     

      get "/quizzes/index", to: "quizzes#index"

      get "/questions/question_for_specific_quiz" , to: "questions#question_for_specific_quiz"
      get "/materials/materials_for_specific_course_of_specific_type" , to: "materials#materials_for_specific_course_of_specific_type"
      get "/materials/materials_for_specific_course" , to: "materials#materials_for_specific_course"

      
      get "/quizzes/quizzes_for_specific_course" , to: "quizzes#quizzes_for_specific_course"

      get "/courses/instructor", to: "courses#courses_for_specific_instructor"
      put "/users/change_role", to: "users#change_role"

        # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
