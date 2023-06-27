class Paypal extends Payment{
    String email;

    public Paypal(String email, Integer id){
        super(id);
        this.email=email;
    }
}