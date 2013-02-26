# with Minitest::Spec
guard 'minitest' do
  watch(%r|^spec/(.*)_spec\.rb|)
  watch(%r|^plugin/(.*)([^/]+)\.rb|) { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r|^spec/spec_helper\.rb|)   { "test" }
end
