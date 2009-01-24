package soup.models {
  import org.restfulx.collections.ModelsCollection;
  import org.restfulx.models.RxModel;
  
  [Resource(name="projects")]
  [Bindable]
  public class Project extends RxModel {
    public static const LABEL:String = "name";

    public var name:String = "";

    public var notes:String = "";

    public var completed:Boolean = false;

    [HasMany]
    public var tasks:ModelsCollection;
    
    public function Project() {
      super(LABEL);
    }
  }
}
