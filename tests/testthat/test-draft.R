test_that("create_draft, drafts, draft and send_draft", {
  skip_unless_authenticated()

  my_email <- Sys.getenv("GMAILR_EMAIL")

  mail <- mime(To = my_email, Subject="hello", body = "how are you doing?")

  d1 <- create_draft(mail)
  all_ds <- drafts()

  expect_equal(id(all_ds)[[1]], id(d1))

  d2 <- draft(id(d1))
  expect_equal(id(d2), id(d1))

  expect_equal(to(d2), my_email)
  expect_equal(subject(d2), "hello")
  expect_equal(body(d2), "how are you doing?\r\n")

  m1 <- send_draft(d2)
  msg1 <- message(id(m1))

  expect_true("SENT" %in% msg1$labelIds)
})