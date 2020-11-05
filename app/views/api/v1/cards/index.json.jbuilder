json.array! @cards do |card|
  json.id card.id
  json.japanese_text card.japanese_text
  json.english_text card.english_text
  json.source card.source
  json.phase card.phase
  json.note card.note
  json.user_id card.user_id
  json.done card.done
  json.done_time card.done_time
end
