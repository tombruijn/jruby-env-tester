use std::env;

#[no_mangle]
#[allow(dead_code)]
pub unsafe extern "C" fn env_test() {
    match env::var("FOO") {
        Ok(value)  => {
            println!("Extension result: FOO = {:?}", value);
        }
        Err(_) => {
            println!("Extension result: FOO is not set")
        }
    }
}
