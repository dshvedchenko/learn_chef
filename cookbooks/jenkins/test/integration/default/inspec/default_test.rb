# # encoding: utf-8

describe command('wget -O - http://localhost:8080') do
  its(:stdout) {should match(/Forbidden/) }
end
