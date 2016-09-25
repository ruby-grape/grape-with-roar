Fabricator(:acme_models_spline, class_name: :'Acme::Models::Spline') do
  name Fabricate.sequence(:name) { |i| "spline-#{i}-name" }
end
