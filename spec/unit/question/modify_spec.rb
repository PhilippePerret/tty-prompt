# encoding: utf-8

require 'spec_helper'

RSpec.describe TTY::Prompt::Question, '#modify' do
  it 'preserves answer for unkown modification' do
    prompt = TTY::TestPrompt.new
    prompt.input << 'piotr'
    prompt.input.rewind
    answer = prompt.ask("What is your name?") { |q| q.modify(:none) }
    expect(answer).to eq('piotr')
  end

  it 'converts to upper case' do
    prompt = TTY::TestPrompt.new
    prompt.input << 'piotr'
    prompt.input.rewind
    answer = prompt.ask("What is your name?") { |q| q.modify(:upcase) }
    expect(answer).to eq('PIOTR')
  end

  it 'trims whitespace' do
    prompt = TTY::TestPrompt.new
    prompt.input << " Some   white\t   space\t \there!   \n"
    prompt.input.rewind
    answer = prompt.ask('Enter some text: ') { |q| q.modify(:trim) }
    expect(answer).to eq("Some   white\t   space\t \there!")
  end

  it 'collapses whitespace' do
    prompt = TTY::TestPrompt.new
    prompt.input << " Some   white\t   space\t \there!   \n"
    prompt.input.rewind
    answer = prompt.ask('Enter some text: ') { |q| q.modify(:collapse) }
    expect(answer).to eq(' Some white space here! ')
  end

  it 'strips and collapses whitespace' do
    prompt = TTY::TestPrompt.new
    prompt.input << " Some   white\t   space\t \there!   \n"
    prompt.input.rewind
    answer = prompt.ask('Enter some text: ') { |q| q.modify(:strip, :collapse) }
    expect(answer).to eq('Some white space here!')
  end
end
