using System;
using System.Configuration;
using System.Collections.Specialized;
using UIKit;

namespace BuildConfig.iOS
{
    public partial class ViewController : UIViewController
    {
        int count = 1;

        public ViewController(IntPtr handle) : base(handle)
        {
        }

        public override void ViewDidLoad()
        {
            base.ViewDidLoad();

            // Perform any additional setup after loading the view, typically from a nib.
            Button.AccessibilityIdentifier = "myButton";
            Button.TouchUpInside += delegate
            {
                var title = string.Format("{0} clicks!", count++);
                Button.SetTitle(title, UIControlState.Normal);
            };
            string sAttr;

            // Read a particular key from the config file            
            sAttr = ConfigurationManager.AppSettings.Get("Key0");
            Console.WriteLine("The value of Key0: " + sAttr);

            // Read all the keys from the config file
            NameValueCollection sAll;
            sAll = ConfigurationManager.AppSettings;

            foreach (string s in sAll.AllKeys)
                Console.WriteLine("Key: " + s + " Value: " + sAll.Get(s));
            Console.ReadLine();

            var value = System.Environment.GetEnvironmentVariable("Country");
            Console.WriteLine(value + "fgfdgfg");

            Console.WriteLine(AppConstant.ApiUrl);
            var value1 = System.Environment.GetEnvironmentVariable("API_URL");
            Console.WriteLine(value1 + "fgfdgfg");
        }

        public override void DidReceiveMemoryWarning()
        {
            base.DidReceiveMemoryWarning();
            // Release any cached data, images, etc that aren't in use.		
        }
    }
}
