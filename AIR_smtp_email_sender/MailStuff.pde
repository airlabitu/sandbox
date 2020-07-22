// Example functions that send mail (smtp)


// A function to send mail

void sendMail() {
  // Create a session
  String host = "my-smtp-server"; // set smtp server to use  ---  e.g. "smtp.office365.com"
  Properties props=new Properties();

  // SMTP Session
  props.put("mail.transport.protocol", "smtp");
  props.put("mail.smtp.host", host);
  props.put("mail.smtp.port", "587"); // set smtp port to use  ---  e.g. "587" for office365 
  props.put("mail.smtp.auth", "true");
  props.put("mail.smtp.starttls.enable","true"); // We need TTLS, which gmail / office365 mails requires

  // Create a session
  Session session = Session.getDefaultInstance(props, new Auth());

  try
  {
    
    MimeMessage message = new MimeMessage(session); // Make a new message

    message.setFrom(new InternetAddress("from-email@my-domain.dk", "My name")); // From

    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("recepient-email@recepient-domain.dk", false)); // To
    
    InternetAddress ia [] = {new InternetAddress("my-reply-to-email@my-domain.dk", "Reply to name")};
    message.setReplyTo(ia); // Reply to

    message.setSubject("Hello World!"); // Subject text
    message.setText("It's great to be here. . ."); // Body text

    Transport.send(message); // Send the message
    println("Mail sent!");
  }
  catch(Exception e) // Exception handling
  {
    e.printStackTrace();
  }

}
